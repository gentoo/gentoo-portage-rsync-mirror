# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vlevel/vlevel-0.5.ebuild,v 1.13 2012/06/09 23:27:14 zmedico Exp $

IUSE=""

inherit eutils multilib

DESCRIPTION="Dynamic compressor to amplify quiet parts of music"
HOMEPAGE="http://vlevel.sourceforge.net/"
SRC_URI="mirror://sourceforge/vlevel/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="amd64 ~ppc ~sparc x86"

RDEPEND="media-libs/ladspa-sdk"
DEPEND="${RDEPEND}
	app-arch/gzip"

src_compile() {
	emake CXXFLAGS="$CXXFLAGS -fPIC -DPIC" || die "emake failed"
}

src_install() {
	dodir "/usr/bin" || die

	einstall PREFIX="${D}/usr/bin/" LADSPA_PREFIX="${D}/usr/$(get_libdir)/ladspa/" || die

	dodoc README TODO docs/notes.txt docs/technical.txt || die

	dodir "/usr/share/doc/${P}/examples" || die
	cp utils/* "${D}/usr/share/doc/${P}/examples/" || die

	for file in levelplay raw2wav vlevel-dir README; do
		fperms 644 /usr/share/doc/${P}/examples/${file} || die
	done

	gzip -9 "${D}/usr/share/doc/${P}/examples/README" || die
}
