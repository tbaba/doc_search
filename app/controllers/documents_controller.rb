# frozen_string_literal: true

class DocumentsController < ApplicationController
  permits :title, :body

  def index(freeword: nil)
    @documents = if freeword
                   Document.search(freeword)
                 else
                   Document.all
                 end
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
