# frozen_string_literal: true

class DocumentsController < ApplicationController
  permits :title, :body

  def index
    @documents = Document.all
  end

  def show(id)
    @document = Document.find(id)
  end

  def new
    @document = Document.new
  end

  def create(document)
    @document = Document.new(document)

    if @document.save
      redirect_to @document, notice: "Document was successfully created."
    else
      render "edit"
    end
  end
end
