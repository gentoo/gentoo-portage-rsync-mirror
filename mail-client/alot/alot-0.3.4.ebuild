# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/alot/alot-0.3.4.ebuild,v 1.1 2013/04/18 13:15:13 aidecoe Exp $

EAPI=4

PYTHON_DEPEND="2:2.7"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[456] 3.*"

inherit distutils eutils vcs-snapshot

DESCRIPTION="Experimental terminal UI for net-mail/notmuch written in Python"
HOMEPAGE="https://github.com/pazz/alot"
SRC_URI="${HOMEPAGE}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="
	doc? ( dev-python/sphinx )
	"
RDEPEND="
	>=dev-python/configobj-4.6.0
	dev-python/pygpgme
	>=dev-python/twisted-10.2.0
	>=dev-python/urwid-1.1.0
	net-mail/mailbase
	>=net-mail/notmuch-0.13[crypt,python]
	sys-apps/file[python]
	"

ALOT_UPDATE=""

pkg_setup() {
	python_pkg_setup

	if has_version "<${CATEGORY}/${PN}-0.3.2"; then
		ALOT_UPDATE="yes"
	fi
}

src_prepare() {
	#epatch "${FILESDIR}/${PV}-subject-fix.patch"
	find "${S}" -name '*.py' -print0 | xargs -0 -- sed \
		-e '1i# -*- coding: utf-8 -*-' -i || die

	distutils_src_prepare

	local md
	for md in *.md; do
		mv "${md}" "${md%.md}"
	done
}

src_compile() {
	distutils_src_compile

	if use doc; then
		pushd docs || die
		emake html
		popd || die
	fi
}

src_install() {
	distutils_src_install

	dodir /usr/share/alot
	insinto /usr/share/alot
	doins -r extra

	if use doc; then
		dohtml -r docs/build/html/*
	fi
}

pkg_postinst() {
	if [[ ${ALOT_UPDATE} = yes ]]; then
		ewarn "The syntax of theme-files and custom tags-sections of the config"
		ewarn "has been changed.  You have to revise your config.  There are"
		ewarn "converter scripts in /usr/share/alot/extra to help you out with"
		ewarn "this:"
		ewarn ""
		ewarn "  * tagsections_convert.py for your ~/.config/alot/config"
		ewarn "  * theme_convert.py to update your custom theme files"
	fi
}
