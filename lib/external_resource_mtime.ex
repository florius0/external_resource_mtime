defmodule ExternalResourceMtime do
  @external_resource "lib/external_resource"

  @content File.read!(@external_resource)

  def content, do: @content
end
