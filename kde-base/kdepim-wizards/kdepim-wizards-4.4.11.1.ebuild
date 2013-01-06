# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-wizards/kdepim-wizards-4.4.11.1.ebuild,v 1.7 2012/12/08 12:04:14 dilfridge Exp $

EAPI=4

KMNAME="kdepim"
KMMODULE="wizards"
inherit kde4-meta

DESCRIPTION="KDE PIM wizards"
IUSE="debug"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux"

DEPEND="
	$(add_kdebase_dep kdepimlibs '' 4.6)
	$(add_kdebase_dep kdepim-kresources)
	$(add_kdebase_dep libkdepim)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	kmail/
	knotes/
	kresources/groupwise/
	kresources/kolab/
	kresources/slox/
"

PATCHES=( "${FILESDIR}/${P}-underlinking.patch" )

src_prepare() {
	ln -s "${EKDEDIR}"/include/kdepim-kresources/{kabcsloxprefs.h,kcalsloxprefs.h} \
		kresources/slox/ \
		|| die "Failed to link extra_headers."
	ln -s "${EKDEDIR}"/include/kdepim-kresources/{kabc_groupwiseprefs,kcal_groupwiseprefsbase}.h \
		kresources/groupwise/ \
		|| die "Failed to link extra_headers."

	kde4-meta_src_prepare
}
