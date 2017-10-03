# Example inputs
# valid shifts = {0, 3, 5}
sigma1 = "abc"
t1 = "abaababacba"
p1 = "aba"

# valid shifts = {17}
sigma2 = "abcdefghijklmnopqrstuvwxyz"
t2 = "this is a simple example"
p2 = "example"

# valid shifts = {1, 4}
sigma3 = "abc"
t3 = "cabcabcabbc"
p3 = "abcab"

def bcrTable(sigma, pattern):
  n = len(sigma)
  m = len(pattern)
  bcr = {}
  for i in range(0, n):
    bcr[sigma[i]] = 0
  for i in range(0, m):
    bcr[pattern[i]] = i + 1
  return bcr

def findSuffixShift(badchar, partialMatch, pattern, index):
  l = len(partialMatch)
  m = len(pattern)

  # Rightmost character always has a shift value of 1.
  if (index == m - 1):
    return 1

  # CASE 1: Check for whole occurances of the partial match.

  # Find the leftmost occurance (prefix) of the suffix, such that it
  #   won't immediately find another bad character.
  # Shift by (the length of the suffix/prefix) + (the distance of the badchar
  #   from the end of the matching prefix)
  for i in range(1, m):
    k = i + l
    if (pattern[i:k] == partialMatch and pattern[i - 1] != badchar):
      return l + index - i - 1

  # CASE 2: Check for suffixes of the partial match at the very beginning
  #         of the pattern.

  # Take increasingly small suffixes (size n) of the partial match, down
  #   to n = 2, and check if they equal the first n characters of the
  #   pattern. As soon as one does, return the (index of the bad
  #   character) + (the length of the matching suffix of the partial
  #   match).
  for n in range(l - 1, 1, -1):
    suffix = partialMatch[l - n:l]
    prefix = pattern[0:n]
    if (suffix == prefix):
      return index + n

  return m

def gsrTable(pattern):
  m = len(pattern)
  gsr = []
  suffix = ""
  for i in range(m - 1, -1, -1):
    gsr = [findSuffixShift(pattern[i], suffix, pattern, i)] + gsr
    suffix = pattern[i] + suffix
  return gsr

def printValidShifts(sigma, text, pattern):
  n = len(text)
  m = len(pattern)

  # Preprocessing for lookup tables
  bcr = bcrTable(sigma, pattern)
  gsr = gsrTable(pattern)

  shift = 0
  while shift <= n - m:
    j = m - 1

    while j >= 0 and pattern[j] == text[shift + j]:
      j = j - 1
    if j < 0:
      print(shift)
      shift = shift + gsr[0] - 1
    else:
      shift = shift + max(gsr[j], j - bcr[text[shift + j]])
