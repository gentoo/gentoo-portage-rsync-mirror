# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mew/mew-6.2.ebuild,v 1.7 2012/03/18 17:46:12 armin76 Exp $

inherit elisp

DESCRIPTION="Great MIME mail reader for Emacs/XEmacs"
HOMEPAGE="http://www.mew.org/"
SRC_URI="http://www.mew.org/Release/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="ssl linguas_ja"
RESTRICT="test"

DEPEND="sys-libs/zlib"
RDEPEND="${DEPEND}
	ssl? ( net-misc/stunnel )"

SITEFILE="50${PN}-gentoo.el"

src_compile() {
	econf \
		--with-elispdir=${SITELISP}/${PN} \
		--with-etcdir=${SITEETC}/${PN}
	emake || die "emake failed"

	if use linguas_ja; then
		emake jinfo || die "emake jinfo failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	if use linguas_ja; then
		emake DESTDIR="${D}" install-jinfo || die "emake install-jinfo failed"
	fi

	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	dodoc 00api 00changes* 00diff 00readme mew.dot.* || die "dodoc failed"
}

pkg_postinst() {
	elisp-site-regen
	elog "Please refer to /usr/share/doc/${PF} for sample configuration files."
}
