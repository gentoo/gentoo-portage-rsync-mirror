# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/subsurface/subsurface-3.0.2-r1.ebuild,v 1.1 2013/04/03 21:16:11 tomwij Exp $

EAPI="5"

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://subsurface.hohndel.org/subsurface.git"
	GIT_ECLASS="git-2"
	LIBDC_V="0.3.0"
else
	SRC_URI="http://subsurface.hohndel.org/downloads/Subsurface-${PV}.tgz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	LIBDC_V="0.3.0"
fi

inherit eutils gnome2-utils ${GIT_ECLASS}

LINGUAS="bg bg_BG de de_DE de_CH es es_ES fi fi_FI fr fr_FR hr hr_HR it it_IT
	nb nb_NO nl nl_NL nn no ru ru_RU sk sk_SK sv sv_SE"

DESCRIPTION="An open source dive log program"
HOMEPAGE="http://subsurface.hohndel.org"
LICENSE="GPL-2"
SLOT="0"
IUSE="doc map usb"
for LINGUA in ${LINGUAS}; do
	IUSE+=" linguas_${LINGUA}"
done

RDEPEND="dev-libs/glib:2
	dev-libs/libxml2
	dev-libs/libxslt
	dev-libs/libzip
	gnome-base/gconf:2
	map? ( sci-geosciences/osm-gps-map )
	net-libs/libsoup:2.4
	sys-libs/glibc
	virtual/libusb
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2
	x11-libs/pango
"
DEPEND="${RDEPEND}
	>=dev-libs/libdivecomputer-${LIBDC_V}[static-libs,usb?]
	virtual/pkgconfig
	doc? ( app-text/asciidoc )
"

src_unpack() {
	if [[ ${PV} = *9999* ]]; then
		git-2_src_unpack
	elif [[ "${SRC_URI}" == *git* ]]; then
		unpack ${A}
		mv subsurface-v${PV}-* ${P} || die "Failed to mv the failes to ${P}."
	else
		mkdir "${P}" && cd "${P}" || die "Failed to create/change to ${P}."
		unpack ${A}
	fi
}

src_prepare() {
	# Don't hardcode gcc.
	sed -i 's|CC\=gcc||' Makefile || die "Failed to fix gcc hardcode issues."

	# Don't hardcode CFLAGS.
	sed -i 's|CFLAGS\=.*||' Makefile || die "Failed to fix hardcoded CFLAGS."

	# Don't call gtk_update_icon_cache.
	sed -i -e "s|\$(gtk_update_icon_cache)|:|" Makefile || die "Failed to disable gtk_update_icon_cache call."
}

src_compile() {
	emake CC=$(tc-getCC)

	if use doc; then
		emake doc
	fi
}

src_install() {
	default

	# Remove unwanted linguas
	local del
	for LANG in $(ls "${D}/usr/share/locale"); do
		del=1
		for LINGUA in ${LINGUAS}; do
			if [[ ${LANG/.UTF-8/} == ${LINGUA} ]]; then
				if use linguas_${LINGUA}; then
					del=0
				fi
				break
			fi
		done
		if [[ ${del} == 1 ]]; then
			rm -r "${D}/usr/share/locale/${LANG}" || die "Removing language ${LANG} failed."
		fi
	done

	if use doc; then
		dohtml -r "${S}/Documentation/"
	fi
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
