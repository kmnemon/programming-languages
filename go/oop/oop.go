package oop

import "fmt"

type Payable interface {
	calculateWages() int
}

func defaultCalculateWages() int {
	return 10000
}

type ProvidesTreatment interface {
	treat(name string)
}

func defaultTreat(name string) {
	fmt.Println("I have treated " + name)
}

type ProvidesDiagnosis interface {
	diagnose() string
}

func defaultDiagnose() string {
	return "He's dead, Jim"
}

type ConductsSurgery interface {
	performSurgery()
}

func defaultPerformSurgery() {
	fmt.Println("Success!")
}

type HasRestTime interface {
	takeBreak()
}

func defaultTakeBreak() {
	fmt.Println("Time to watch TV")
}

type NeedsTraining interface {
	study()
}

func defaultStudy() {
	fmt.Println("I'm reading a book")
}

type Employee interface {
	Payable
	HasRestTime
	NeedsTraining
}

type Receptionist struct{}
type Nurse struct{}
type Doctor struct{}
type Surgeon struct{}

func (r Receptionist) calculateWages() int {
	return defaultCalculateWages()
}

func (r Receptionist) takeBreak() {
	defaultTakeBreak()
}

func (r Receptionist) study() {
	defaultStudy()
}

func (n Nurse) calculateWages() int {
	return defaultCalculateWages()
}

func (n Nurse) takeBreak() {
	defaultTakeBreak()
}

func (n Nurse) study() {
	defaultStudy()
}

func (n Nurse) treat(name string) {
	defaultTreat(name)
}

func (d Doctor) calculateWages() int {
	return defaultCalculateWages()
}

func (d Doctor) takeBreak() {
	defaultTakeBreak()
}

func (d Doctor) study() {
	defaultStudy()
}

func (d Doctor) treat(name string) {
	defaultTreat(name)
}

func (d Doctor) diagnose() string {
	return defaultDiagnose()
}

func (s Surgeon) calculateWages() int {
	return defaultCalculateWages()
}

func (s Surgeon) takeBreak() {
	defaultTakeBreak()
}

func (s Surgeon) study() {
	defaultStudy()
}

func (s Surgeon) diagnose() string {
	return defaultDiagnose()
}

func (s Surgeon) performSurgery() {
	defaultPerformSurgery()
}
