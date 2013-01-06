# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-musicbrainz/python-musicbrainz-0.7.4.ebuild,v 1.1 2011/12/27 05:17:16 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
# ctypes module required.
RESTRICT_PYTHON_ABIS="2.4 3.* *-jython"

inherit distutils

MY_PN="${PN}2"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python Bindings for the MusicBrainz XML Web Service"
HOMEPAGE="http://musicbrainz.org"
SRC_URI="http://ftp.musicbrainz.org/pub/musicbrainz/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE="doc examples"

RDEPEND="media-libs/libdiscid"
DEPEND="${RDEPEND}
	doc? ( dev-python/epydoc )"

S="${WORKDIR}/${MY_P}"

DOCS="AUTHORS.txt CHANGES.txt README.txt"
PYTHON_MODNAME="musicbrainz2"

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		"$(PYTHON -f)" setup.py docs || die "Generation of documentation failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml html/* || die "Installation of documentation failed"
	fi

	if use examples; then
		docinto examples
		dodoc examples/*.txt || die "dodoc failed"
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.py || die "doins failed"
	fi
}
