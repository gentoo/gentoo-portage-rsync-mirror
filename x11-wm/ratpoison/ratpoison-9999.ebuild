# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ratpoison/ratpoison-9999.ebuild,v 1.1 2014/01/29 12:21:49 jer Exp $

EAPI=5

inherit autotools elisp-common eutils git-r3

DESCRIPTION="Ratpoison is an extremely light-weight and barebones wm modelled after screen"
HOMEPAGE="http://www.nongnu.org/ratpoison/"
EGIT_REPO_URI="git://git.savannah.nongnu.org/ratpoison.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug emacs +history +xft"

RDEPEND="
	emacs? ( virtual/emacs )
	history? ( sys-libs/readline )
	virtual/perl-PodParser
	x11-libs/libXinerama
	x11-libs/libXtst
	xft? ( x11-libs/libXft )
"
DEPEND="
	${RDEPEND}
	app-arch/xz-utils
"

SITEFILE=50ratpoison-gentoo.el
DOCS=( AUTHORS ChangeLog NEWS README TODO )

src_prepare() {
	epatch "${FILESDIR}/ratpoison.el-gentoo.patch"
	eautoreconf
}

src_configure() {
	econf \
		--without-electric-fence \
		$(use_enable debug) \
		$(use_with xft) \
		$(usex history '' --disable-history)
}

src_compile() {
	emake CFLAGS="${CFLAGS}"
	if use emacs; then
		elisp-compile contrib/ratpoison.el || die "elisp-compile failed"
	fi
}

src_install() {
	default

	exeinto /etc/X11/Sessions
	newexe "${FILESDIR}"/ratpoison.xsession ratpoison

	insinto /usr/share/xsessions
	doins "${FILESDIR}"/${PN}.desktop || die

	docinto example
	dodoc contrib/{genrpbindings,split.sh} \
		doc/{ipaq.ratpoisonrc,sample.ratpoisonrc}

	rm -rf "${ED}/usr/share/"{doc/ratpoison,ratpoison}

	if use emacs; then
		elisp-install ${PN} contrib/ratpoison.*
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
