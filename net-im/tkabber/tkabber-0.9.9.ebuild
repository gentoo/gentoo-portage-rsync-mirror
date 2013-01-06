# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/tkabber/tkabber-0.9.9.ebuild,v 1.11 2012/03/18 15:32:53 armin76 Exp $

inherit eutils

DESCRIPTION="Tkabber is a Free and Open Source client for the Jabber instant messaging system, written in Tcl/Tk."
HOMEPAGE="http://tkabber.jabber.ru/"
SRC_URI="http://files.jabberstudio.org/tkabber/${P}.tar.gz
	plugins? ( http://files.jabberstudio.org/tkabber/tkabber-plugins-${PV}.tar.gz )"
IUSE="plugins ssl extras"

DEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3
	>=dev-tcltk/tclxml-3.0
	>=dev-tcltk/tcllib-1.3
	>=dev-tcltk/bwidget-1.3
	ssl? ( >=dev-tcltk/tls-1.4.1 )
	>=dev-tcltk/tkXwin-1.0
	>=dev-tcltk/tkTheme-1.0"
RDEPEND="${DEPEND}"

# Disabled because it depends on gpgme 0.3.x
#	crypt? ( >=dev-tcltk/tclgpgme-1.0 )

LICENSE="GPL-2"
KEYWORDS="amd64 x86"
SLOT="0"

pkg_setup() {
	if ! use extras; then
		ewarn "You have the extras use flag off. That means that proxy file transfers will not work"
		ewarn "If you need that press Contrl-C now and activate it!"
	fi
	if has_version '>=dev-tcltk/tclxml-3.0' \
		&& ! built_with_use --missing true dev-tcltk/tclxml expat ; then
		eerror "tclxml is missing expat support."
		eerror "Please add 'expat' to your USE flags, and re-emerge tclxml."
		die "tclxml needs expat support"
	fi
}

src_compile() {
	# dont run make, because the Makefile is broken with all=install
	echo -n
	if use extras; then
		epatch "${FILESDIR}"/NAT_HTTP_filetransfer.diff
	fi
}

src_install() {
	dodir /usr/share/tkabber
	cp -R *.tcl plugins pixmaps textundo aniemoteicons ifacetk \
	emoticons-tkabber msgs mclistbox-1.02 \
	jabberlib-tclxml sounds "${D}"/usr/share/tkabber

	if use plugins; then
		mkdir "${D}"/usr/share/tkabber/site-plugins
		cp -R "${WORKDIR}"/tkabber-plugins-${PV}/* \
		"${D}"/usr/share/tkabber/site-plugins
		newdoc "${WORKDIR}"/tkabber-plugins-${PV}/README README.plugins
	fi

	cat <<-EOF > tkabber
	#!/bin/sh
	TKABBER_SITE_PLUGINS=/usr/share/tkabber/site-plugins \
	exec wish /usr/share/tkabber/tkabber.tcl -name tkabber
	EOF

	chmod +x tkabber
	dobin tkabber
	dodoc AUTHORS ChangeLog INSTALL README
	dohtml README.html
	cp -R doc examples contrib "${D}"/usr/share/doc/${PF}
}

pkg_postinst() {
	elog "There's no UI option to disable emoticons yet, however"
	elog "you can put the following into your ~/.tkabber/config.tcl"
	elog
	elog "hook::add finload_hook {"
	elog " array unset emoteicons::emoteicons"
	elog "}"
}
