defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    Enum.map dna, &nucleotide_transcription &1
  end

  def nucleotide_transcription(?A) do ?U end
  def nucleotide_transcription(?C) do ?G end
  def nucleotide_transcription(?T) do ?A end
  def nucleotide_transcription(?G) do ?C end
end
