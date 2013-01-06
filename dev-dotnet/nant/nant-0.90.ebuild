# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/nant/nant-0.90.ebuild,v 1.5 2012/05/04 03:56:56 jdhore Exp $

EAPI="3"

inherit mono multilib eutils

DESCRIPTION=".NET build tool"
HOMEPAGE="http://nant.sourceforge.net/"
SRC_URI="mirror://sourceforge/nant/${P/_/-}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=dev-lang/mono-2.0"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

# This build is not parallel build friendly
MAKEOPTS="${MAKEOPTS} -j1"

S="${WORKDIR}/${P/_/-}"

src_compile() {
	emake || die
}

src_install() {
	emake prefix="${ED}/usr" install || die "install failed"

	# Fix ${ED} showing up in the nant wrapper script, as well as silencing
	# warnings related to the log4net library
	sed -i \
		-e "s:${ED}::" \
		-e "2iexport MONO_SILENT_WARNING=1" \
		-e "s:${ED}::" \
		"${ED}"/usr/bin/nant || die "Sed nant failed"

	dodoc README.txt || die
}
