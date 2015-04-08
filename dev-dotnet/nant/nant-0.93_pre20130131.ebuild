# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/nant/nant-0.93_pre20130131.ebuild,v 1.1 2013/05/24 21:14:15 pacho Exp $

EAPI=5
inherit mono-env eutils

DESCRIPTION=".NET build tool"
HOMEPAGE="http://nant.sourceforge.net/"
SRC_URI="http://dev.gentoo.org/~pacho/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-lang/mono-2.0"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

# This build is not parallel build friendly
MAKEOPTS="${MAKEOPTS} -j1"

S="${WORKDIR}/${PN}"

src_compile() {
	emake TARGET=mono-4.5 MCS="gmcs -sdk:4"
}

src_install() {
	emake prefix="${ED}/usr" TARGET=mono-4.5 MCS="gmcs -sdk:4" install

	# Fix ${ED} showing up in the nant wrapper script, as well as silencing
	# warnings related to the log4net library
	sed -i \
		-e "s:${ED}::" \
		-e "2iexport MONO_SILENT_WARNING=1" \
		-e "s:${ED}::" \
		"${ED}"/usr/bin/nant || die "Sed nant failed"

	dodoc README.txt
}
