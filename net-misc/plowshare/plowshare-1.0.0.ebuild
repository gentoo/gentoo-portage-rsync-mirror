# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/plowshare/plowshare-1.0.0.ebuild,v 1.1 2014/03/10 20:39:41 voyageur Exp $

EAPI=5

inherit bash-completion-r1

# Git rev of the tag
MY_P="${PN}-8d0540cd0dfc"

DESCRIPTION="Command-line downloader and uploader for file-sharing websites"
HOMEPAGE="http://code.google.com/p/plowshare/"
SRC_URI="http://${PN}.googlecode.com/archive/v${PV}.zip -> ${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE="bash-completion +javascript view-captcha"

RDEPEND="
	>=app-shells/bash-4
	|| ( app-text/recode ( dev-lang/perl dev-perl/HTML-Parser ) )
	|| ( media-gfx/imagemagick[tiff] media-gfx/graphicsmagick[imagemagick,tiff] )
	net-misc/curl
	sys-apps/util-linux
	javascript? ( || ( dev-lang/spidermonkey:0 dev-java/rhino ) )
	view-captcha? ( || ( media-gfx/aview media-libs/libcaca ) )"
DEPEND=""

S=${WORKDIR}/${MY_P}

# NOTES:
# javascript dep should be any javascript interpreter using /usr/bin/js

# Modules using detect_javascript
JS_MODULES="letitbit nowdownload_co rapidgator zalaa zalil_ru zippyshare"

src_prepare() {
	if ! use javascript; then
		for module in ${JS_MODULES}; do
			sed -i -e "s:^${module}.*::" src/modules/config || die "${module} sed failed"
			rm src/modules/${module}.sh || die "${module} rm failed"
		done
	fi

	# Fix doc install path
	sed -i -e "/^DOCDIR/s|plowshare4|${P}|" Makefile || die "sed failed"

	if ! use bash-completion
	then
		sed -i -e \ "/^install:/s/install_bash_completion//" \
			Makefile || die "sed failed"
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
}

pkg_postinst() {
	if ! use javascript; then
		ewarn "Without javascript you will not be able to use:"
		ewarn " ${JS_MODULES}"
	fi
}
