# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/plowshare/plowshare-20130520.ebuild,v 1.2 2013/06/15 23:49:56 voyageur Exp $

EAPI=5

inherit bash-completion-r1

MY_P="${PN}4-snapshot-git${PV}.2b2d736"

DESCRIPTION="Command-line downloader and uploader for file-sharing websites"
HOMEPAGE="http://code.google.com/p/plowshare/"
SRC_URI="http://${PN}.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE="bash-completion +javascript scripts view-captcha"

RDEPEND="
	>=app-shells/bash-4
	|| ( app-text/recode ( dev-lang/perl dev-perl/HTML-Parser ) )
	|| ( media-gfx/imagemagick[tiff] media-gfx/graphicsmagick[imagemagick,tiff] )
	net-misc/curl
	sys-apps/util-linux
	javascript? ( || ( dev-lang/spidermonkey dev-java/rhino ) )
	view-captcha? ( || ( media-gfx/aview media-libs/libcaca ) )"
DEPEND=""

S=${WORKDIR}/${MY_P}

# NOTES:
# javascript dep should be any javascript interpreter using /usr/bin/js

src_prepare() {
	# Modules using detect_javascript
	if ! use javascript; then
		sed -i -e 's:^rapidgator.*::' \
			-e 's:^zalaa*::' \
			-e 's:^zippyshare*::' \
			src/modules/config || die "sed failed"
		rm src/modules/{rapidgator,zalaa,zippyshare}.sh || die "rm failed"
	fi

	# Don't let 'make install' install docs.
	sed -i -e "/INSTALL.*DOCDIR/d" Makefile || die "sed failed"

	if use bash-completion; then
		sed -i -e \
			"s,/usr/local\(/share/plowshare4/modules/config\),${EPREFIX}/usr\1," \
			etc/plowshare.completion || die "sed failed"
	fi
}

src_compile() {
	# There is a Makefile but it's not compiling anything, let's not try.
	:
}

src_test() {
	# Disable tests because all of them need a working Internet connection.
	:
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install

	dodoc AUTHORS README

	if use scripts; then
		exeinto /usr/bin/
		doexe contrib/{plowdown_{add_remote_loop,loop,parallel}}.sh
	fi

	if use bash-completion; then
		newbashcomp etc/${PN}.completion ${PN}
	fi
}

pkg_postinst() {
	if ! use javascript; then
		ewarn "Without javascript you will not be able to use:"
		ewarn " rapidgator, zalaa, zippyshare"
	fi
}
