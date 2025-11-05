class PenggalanganDanaBeasiswa < ApplicationRecord
  self.table_name = 'PenggalanganDanaBeasiswa'
  self.primary_key = 'penggalangan_dana_beasiswa_id'
  
  has_many :bantuan_dana_beasiswa, class_name: "BantuanDanaBeasiswa"
  has_many :donasi, class_name: "Donasi"

  belongs_to :penanggung_jawab, 
              class_name: "PenanggungJawab", 
              foreign_key: "penanggung_jawabs_role", 
              primary_key: "role", 
              optional: true

  validates :judul, presence: true
  validates :deskripsi, presence: true
  validates :target_dana, presence: true
  validates :target_penerima, presence: true

  scope :on_going, -> { where(status: Enums::StatusPenggalanganDanaBeasiswa::ONGOING) }
  scope :done, -> { where(status: Enums::StatusPenggalanganDanaBeasiswa::DONE) }
end
