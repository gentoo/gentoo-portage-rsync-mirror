# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmon+smp/wmmon+smp-1.0-r1.ebuild,v 1.13 2010/08/30 15:52:58 s4t4n Exp $

IUSE=""

S=${WORKDIR}/wmmon.app
S2=${S}/wmmon
DESCRIPTION="Dockapp CPU monitor resembling Xosview, support for smp"
SRC_URI="http://www.ne.jp/asahi/linux/timecop/wmmon+smp.tar.gz"
HOMEPAGE="http://www.ne.jp/asahi/linux/timecop/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ppc64"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

src_unpack()
{
	unpack ${A}
	cd "${S}"

	# Respect LDFLAGS, see bug #335047
	sed -i 's/cc -o/${CC} ${LDFLAGS} -o/' "${S2}/Makefile"
}

src_compile() {
	cd "${S2}"
	emake || die
}

src_install () {
	exeinto /usr/bin
	cp "${S2}"/wmmon "${S2}"/wmmon+smp
	doexe "${S2}"/wmmon+smp
	dodoc "${S}"/README
}
