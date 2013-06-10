# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/modemmanager/modemmanager-0.7.991.ebuild,v 1.2 2013/06/10 18:45:57 pacho Exp $

EAPI="5"
GNOME_ORG_MODULE="ModemManager"

inherit eutils gnome.org user multilib readme.gentoo toolchain-funcs udev virtualx

DESCRIPTION="Modem and mobile broadband management libraries"
HOMEPAGE="http://cgit.freedesktop.org/ModemManager/ModemManager/"

LICENSE="GPL-2+"
SLOT="0/1" # subslot = dbus interface version, i.e. N in org.freedesktop.ModemManager${N}
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="policykit +qmi qmi-newest test"
REQUIRED_USE="qmi-newest? ( qmi )"

RDEPEND="
	>=dev-libs/glib-2.32:2
	net-dialup/ppp
	>=virtual/udev-147[gudev]
	policykit? ( >=sys-auth/polkit-0.106 )
	qmi? ( net-libs/libqmi )
"
DEPEND="${RDEPEND}
	test? (
		dev-lang/python:2.7
		dev-python/dbus-python[python_targets_python2_7]
		dev-python/pygobject:2[python_targets_python2_7] )
	dev-util/gdbus-codegen
	>=dev-util/intltool-0.40
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	DOC_CONTENTS="If your USB modem shows up as a Flash drive when you plug it in,
		You should install sys-apps/usb_modeswitch which will automatically
		switch it over to USB modem mode whenever you plug it in.\n"

	if use policykit; then
		DOC_CONTENTS+="\nTo control your modem without needing to enter the root password,
			add your user account to the 'plugdev' group."
	fi

	# Use python2.7 shebangs for test scripts
	sed -e 's@\(^#!.*python\)@\12.7@' \
		-i test/*.py || die

	epatch_user
}

src_configure() {
	# ppp-2.4.5 changes the plugin directory
	if has_version '=net-dialup/ppp-2.4.4*'; then
		pppd_plugin_dir="pppd/2.4.4"
	elif has_version '=net-dialup/ppp-2.4.5*'; then
		pppd_plugin_dir="pppd/2.4.5"
	fi

	# We don't have mbim in the tree
	econf \
		--disable-more-warnings \
		--with-udev-base-dir="$(udev_get_udevdir)" \
		--disable-static \
		--with-dist-version=${PVR} \
		--with-pppd-plugin-dir="/usr/$(get_libdir)/${pppd_plugin_dir}" \
		$(use_with policykit polkit) \
		$(use_with qmi) \
		$(use_with qmi-newest newest-qmi-commands) \
		$(use_with test tests) \
		--without-mbim
}

src_install() {
	default

	# Allow users in plugdev group full control over their modem
	if use policykit; then
		insinto /usr/share/polkit-1/rules.d/
		doins "${FILESDIR}"/01-org.freedesktop.ModemManager.rules
	fi

	prune_libtool_files --modules

	readme.gentoo_create_doc
}

pkg_postinst() {
	use policykit && enewgroup plugdev

	# The polkit rules file moved to /usr/share
	old_rules="${EROOT}etc/polkit-1/rules.d/01-org.freedesktop.ModemManager.rules"
	if [[ -f "${old_rules}" ]]; then
		case "$(md5sum ${old_rules})" in
		  c5ff02532cb1da2c7545c3069e5d0992* | 5c50f0dc603c0a56e2851a5ce9389335* )
			# Automatically delete the old rules.d file if the user did not change it
			elog
			elog "Removing old ${old_rules} ..."
			rm -f "${old_rules}" || eerror "Failed, please remove ${old_rules} manually"
			;;
		  * )
			elog "The ${old_rules}"
			elog "file moved to /usr/share/polkit-1/rules.d/ in >=modemmanager-0.5.2.0-r2"
			elog "If you edited ${old_rules}"
			elog "without changing its behavior, you may want to remove it."
			;;
		esac
	fi

	readme.gentoo_print_elog
}
