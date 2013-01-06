# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/slrn/slrn-0.9.8.1_p1.ebuild,v 1.7 2011/10/23 15:09:58 armin76 Exp $

MY_P=${P/_p/pl}

DESCRIPTION="a s-lang based newsreader"
HOMEPAGE="http://slrn.sourceforge.net"
SRC_URI="http://${PN}.sourceforge.net/patches/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="nls ssl uudeview"

RDEPEND="virtual/mta
	app-arch/sharutils
	>=sys-libs/slang-2.1.3
	ssl? ( dev-libs/openssl )
	uudeview? ( dev-libs/uulib )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf --with-docdir=/usr/share/doc/${PF} \
		--with-slrnpull $(use_with uudeview) \
		$(use_enable nls) $(use_with ssl)

	emake || die "emake failed."
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed."
	prepalldocs
}
