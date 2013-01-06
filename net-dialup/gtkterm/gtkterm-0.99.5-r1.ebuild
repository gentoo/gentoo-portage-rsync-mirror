# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/gtkterm/gtkterm-0.99.5-r1.ebuild,v 1.4 2012/05/03 03:54:07 jdhore Exp $

EAPI=2

DESCRIPTION="A serial port terminal written in GTK+, similar to Windows' HyperTerminal."
HOMEPAGE="http://www.jls-info.com/julien/linux/"
SRC_URI="http://www.jls-info.com/julien/linux/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="nls"

RDEPEND="x11-libs/gtk+:2
	x11-libs/vte:0"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

# Supported languages and translated documentation
# Be sure all languages are prefixed with a single space!
MY_AVAILABLE_LINGUAS=" fr hu ru"
IUSE="${IUSE} ${MY_AVAILABLE_LINGUAS// / linguas_}"

src_prepare() {
	if use nls ; then
		cp "${FILESDIR}"/ru.po "${S}"/po/ || die "adding Russian language support failed"
	fi
}

src_install() {
	einstall || die "einstall failed"

	if use nls; then
		cd "${S}/po"
		local MY_LINGUAS="" lang

		for lang in ${MY_AVAILABLE_LINGUAS} ; do
			if use linguas_${lang} ; then
				MY_LINGUAS="${MY_LINGUAS} ${lang}"
			fi
		done
		if [[ -z "${MY_LINGUAS}" ]] ; then
			#If no language is selected, install 'em all
			MY_LINGUAS="${MY_AVAILABLE_LINGUAS}"
		fi

		elog "Locale messages will be installed for following languages:"
		elog "   ${MY_LINGUAS}"

		for lang in ${MY_LINGUAS}; do
			msgfmt -o ${lang}.mo ${lang}.po && \
				insinto /usr/share/locale/${lang}/LC_MESSAGES && \
				newins ${lang}.mo gtkterm.mo || \
					die "failed to install locale messages for ${lang} language"
		done
	fi
}
