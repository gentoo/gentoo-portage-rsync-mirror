# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monodoc/monodoc-2.0.ebuild,v 1.5 2011/03/05 12:30:54 armin76 Exp $

inherit autotools mono multilib

DESCRIPTION="Documentation for mono's .Net class library"
HOMEPAGE="http://www.go-mono.com"
SRC_URI="http://ftp.novell.com/pub/mono/sources/${PN}/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE="X"

RDEPEND=">=dev-lang/mono-2.0
	www-client/lynx
	!>=dev-lang/mono-2.2"
DEPEND="${RDEPEND}
		app-arch/unzip"
PDEPEND="X? ( >=dev-util/mono-tools-2 )"

RESTRICT="test"

# Parallel build unfriendly
MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Install all our .dlls under $(libdir), not $(prefix)/lib
	if [ $(get_libdir) != "lib" ] ; then
		sed -i -e 's:$(prefix)/lib:$(libdir):'             \
			"${S}"/engine/Makefile.am                        \
		|| die "sed failed"

		sed -i -e 's:libdir=@prefix@/lib:libdir=@libdir@:' \
			-i -e 's:${prefix}/lib:${libdir}:'             \
			"${S}"/monodoc.pc.in                             \
		|| die "sed failed"

		eautoreconf
	fi

}

src_install() {
	emake DESTDIR="${D}" install || die
}
