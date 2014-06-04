# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/pm-utils/pm-utils-1.4.1-r3.ebuild,v 1.2 2014/06/04 20:02:07 ssuominen Exp $

EAPI=5
inherit eutils multilib

DESCRIPTION="Suspend and hibernation utilities"
HOMEPAGE="http://pm-utils.freedesktop.org/"
SRC_URI="http://pm-utils.freedesktop.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="alsa debug ntp video_cards_intel video_cards_radeon"

vbetool="!video_cards_intel? ( sys-apps/vbetool )"
RDEPEND="!<app-laptop/laptop-mode-tools-1.55-r1
	!sys-power/powermgmt-base[-pm-utils(+)]
	sys-apps/dbus
	>=sys-apps/util-linux-2.13
	sys-power/pm-quirks
	alsa? ( media-sound/alsa-utils )
	ntp? ( || ( net-misc/ntp net-misc/openntpd ) )
	amd64? ( ${vbetool} )
	x86? ( ${vbetool} )
	video_cards_radeon? ( app-laptop/radeontool )"
DEPEND="${RDEPEND}"

DOCS="AUTHORS ChangeLog NEWS pm/HOWTO* README* TODO"

src_prepare() {
	local ignore="01grub"
	use ntp || ignore+=" 90clock"

	use debug && echo 'PM_DEBUG="true"' > "${T}"/gentoo
	echo "HOOK_BLACKLIST=\"${ignore}\"" >> "${T}"/gentoo

	epatch \
		"${FILESDIR}"/${PV}-bluetooth-sync.patch \
		"${FILESDIR}"/${PV}-disable-sata-alpm.patch \
		"${FILESDIR}"/${PV}-fix-intel-audio-powersave-hook.patch \
		"${FILESDIR}"/${PV}-logging-append.patch \
		"${FILESDIR}"/${PV}-inhibit-on-right-status.patch

}

src_configure() {
	econf --disable-doc
}

src_install() {
	default
	doman man/*.{1,8}

	# Remove duplicate documentation install
	rm -r "${D}"/usr/share/doc/${PN}

	insinto /etc/pm/config.d
	doins "${T}"/gentoo

	# NetworkManager 0.8.2 is handling suspend/resume on it's own with UPower
	find "${D}" -type f -name 55NetworkManager -exec rm -f '{}' +

	# Punt HAL related file wrt #401257 with `rm -f` copied from what Debian does
	rm -f "${D}"/usr/$(get_libdir)/${PN}/power.d/hal-cd-polling
}
