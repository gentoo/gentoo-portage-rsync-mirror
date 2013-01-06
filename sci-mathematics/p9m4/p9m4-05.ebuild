# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/p9m4/p9m4-05.ebuild,v 1.2 2012/01/08 15:14:11 gienah Exp $

EAPI="4"
PYTHON_DEPEND="2:2.5"

inherit base distutils

MY_PN="p9m4-v"
MY_P="${MY_PN}${PV}"

DESCRIPTION="This is a Graphical User Interface for Prover9 and Mace4."
HOMEPAGE="http://www.cs.unm.edu/~mccune/mace4/"
SRC_URI="http://www.cs.unm.edu/~mccune/prover9/gui/${MY_P}.tar.gz
		http://dev.gentoo.org/~gienah/2big4tree/sci-mathematics/p9m4/p9m4-v05-64bit.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND="dev-python/wxpython
		sci-mathematics/prover9"
DEPEND="${RDEPEND}
		dev-python/setuptools"

PATCHES=("${DISTDIR}/${MY_PN}05-64bit.patch.bz2"
		"${FILESDIR}/${MY_PN}05-use-inst-paths.patch"
		"${FILESDIR}/${MY_PN}05-package.patch"
		"${FILESDIR}/${MY_PN}05-python2.6.patch")

S="${WORKDIR}/${MY_P}/"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	rm -f p9m4-v05/bin/prover9 \
		p9m4-v05/bin/mace4 \
		p9m4-v05/bin/interpformat \
		p9m4-v05/bin/prooftrans \
		p9m4-v05/bin/isofilter \
		p9m4-v05/bin/isofilter2 || die "Could not rm old executables"
	base_src_prepare
	mkdir p9m4 || die "Could not create directory p9m4"
	mv Mac-setup.py \
		Win32-setup.py \
		control.py \
		files.py \
		my_setup.py \
		options.py \
		partition_input.py \
		platforms.py \
		utilities.py \
		wx_utilities.py \
		p9m4 \
		|| die "Could not move package p9m4 python files to p9m4 directory"
	touch p9m4/__init__.py \
		|| die "Could not create empty p9m4/__init__.py file"
	distutils_src_prepare
}

src_install() {
	distutils_src_install
	dosym /usr/bin/prover9-mace4.py /usr/bin/prover9-mace4
	insinto /usr/share
	dodir /usr/share/${PN}/Images
	insinto /usr/share/${PN}/Images
	cd "${S}/Images" \
		|| die "Could not cd to Images"
	doins *.gif *.ico
	if use examples; then
		dodir /usr/share/${PN}/Samples
		insinto /usr/share/${PN}/Samples
		cd "${S}/Samples" \
			|| die "Could not cd to Samples"
		doins *.in

		dodir /usr/share/${PN}/Samples/Equality/Mace4
		insinto /usr/share/${PN}/Samples/Equality/Mace4
		cd "${S}/Samples/Equality/Mace4" \
			|| die "Could not cd to Samples/Equality/Mace4"
		doins *.in

		dodir /usr/share/${PN}/Samples/Equality/Prover9
		insinto /usr/share/${PN}/Samples/Equality/Prover9
		cd "${S}/Samples/Equality/Prover9" \
			|| die "Could not cd to Samples/Equality/Prover9"
		doins *.in

		dodir /usr/share/${PN}/Samples/Non-Equality/Mace4
		insinto /usr/share/${PN}/Samples/Non-Equality/Mace4
		cd "${S}/Samples/Non-Equality/Mace4" \
			|| die "Could cd to Samples/Non-Equality/Mace4"
		doins *.in

		dodir /usr/share/${PN}/Samples/Non-Equality/Prover9
		insinto /usr/share/${PN}/Samples/Non-Equality/Prover9
		cd "${S}/Samples/Non-Equality/Prover9" \
			|| die "Could not cd to Samples/Non-Equality/Prover9"
		doins *.in
	fi
}

pkg_postinst() {
	distutils_pkg_postinst
}
