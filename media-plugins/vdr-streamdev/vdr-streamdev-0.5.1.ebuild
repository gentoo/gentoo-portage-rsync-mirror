# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-streamdev/vdr-streamdev-0.5.1.ebuild,v 1.2 2012/01/02 17:58:38 hd_brummy Exp $

EAPI="3"

inherit vdr-plugin

VERSION="497" # every bump, new version !

DESCRIPTION="VDR Plugin: Client/Server streaming plugin"
HOMEPAGE="http://projects.vdr-developer.org/projects/plg-streamdev"
SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="client +server"

DEPEND=">=media-video/vdr-1.5.9"
RDEPEND="${DEPEND}"

pkg_setup() {
	vdr-plugin_pkg_setup

	if ! use client && ! use server; then
		die "no plugins selected, change useflags and enable at least client or server!"
	fi
}

src_prepare() {
	vdr-plugin_src_prepare
	cd "${S}"

	# make subdir libdvbmpeg respect CXXFLAGS
	sed -i Makefile \
		-e '/CXXFLAGS.*+=/s:^:#:'

	for flag in client server; do
		if ! use ${flag}; then
			sed -i Makefile \
				-e '/^.PHONY:/s/'${flag}'//' \
				-e '/^all:/s/'${flag}'//'
		fi
	done

	sed -i server/Makefile \
		-i client/Makefile \
		-e "s:\$(CXXFLAGS) -shared:\$(CXXFLAGS) \$(LDFLAGS) -shared:"

	fix_vdr_libsi_include server/livestreamer.c
}

src_install() {
	vdr-plugin_src_install

	cd "${S}"
	if use server; then
		insinto /etc/vdr/plugins/streamdev-server
		newins streamdev-server/streamdevhosts.conf streamdevhosts.conf
		chown vdr:vdr "${D}"/etc/vdr -R

		insinto /usr/share/vdr/streamdev
		doins streamdev-server/externremux.sh

		insinto /usr/share/vdr/rcscript
		newins "${FILESDIR}"/rc-addon-0.5.0.sh plugin-streamdev-server.sh

		insinto /etc/conf.d
		newins "${FILESDIR}"/confd-0.5.0 vdr.streamdev-server
	fi
}

pkg_postinst() {
	vdr-plugin_pkg_postinst

	if [[ -e "${ROOT}"/etc/vdr/plugins/streamdev/streamdevhosts.conf ]]; then
		einfo "move config file to new config DIR ${ROOT}/etc/vdr/plugins/streamdev-server/"
		mv "${ROOT}"/etc/vdr/plugins/streamdev/streamdevhosts.conf "${ROOT}"/etc/vdr/plugins/streamdev-server/streamdevhosts.conf
	fi
}
