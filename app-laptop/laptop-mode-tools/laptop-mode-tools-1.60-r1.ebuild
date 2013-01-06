# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/laptop-mode-tools/laptop-mode-tools-1.60-r1.ebuild,v 1.6 2012/06/14 14:28:42 xmw Exp $

EAPI=4

MY_P=${PN}_${PV}

DESCRIPTION="Linux kernel laptop_mode user-space utilities"
HOMEPAGE="http://www.samwel.tk/laptop_mode/"
SRC_URI="http://www.samwel.tk/laptop_mode/tools/downloads/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="acpi apm bluetooth scsi"

RDEPEND="net-wireless/wireless-tools
	sys-apps/ethtool
	sys-apps/hdparm
	acpi? ( sys-power/acpid )
	apm? ( sys-apps/apmd )
	bluetooth? ( net-wireless/bluez )
	scsi? ( sys-apps/sdparm )"
DEPEND=""

S=${WORKDIR}/${MY_P}

src_prepare() {
	# Install 99-laptop-mode.rules to rules.d directory in /lib instead of /etc
	sed -i -e '/udev/s:/etc:/lib:' install.sh || die

	# This should avoid conflict with pm-powersave wrt #327443 and #396703
	cat <<-EOF > "${T}"/${PN}
	HOOK_BLACKLIST="00powersave"
	EOF
}

src_compile() { :; }

src_install() {
	DESTDIR="${D}" \
		INIT_D="none" \
		MAN_D="/usr/share/man" \
		ACPI="$(use acpi && echo force || echo disabled)" \
		PMU="$(false && echo force || echo disabled)" \
		APM="$(use apm && echo force || echo disabled)" \
		./install.sh || die

	dodoc Documentation/*.txt README
	newinitd "${FILESDIR}"/laptop_mode.init-1.4 laptop_mode

	# See src_prepare()
	insinto /etc/pm/config.d
	doins "${T}"/${PN}
}

pkg_postinst() {
	if use acpi || use apm; then
		if use acpi; then
			daemon_name="acpid"
		elif use apm; then
			deamon_name="apmd"
		fi
		ewarn
		ewarn "To enable automatic power state event handling,"
		ewarn "e.g. enabling laptop_mode after unplugging the battery,"
		ewarn "both laptop_mode and the ${daemon_name} daemon"
		ewarn "must be added to a runlevel,"
		ewarn "		rc-update add laptop_mode default"
		ewarn "		rc-update add ${daemon_name} default"
		ewarn
	else
		ewarn
		ewarn "Without USE=\"acpi\" or USE=\"apm\" ${PN} can not"
		ewarn "automatically disable laptop_mode on low battery."
		ewarn
		ewarn "This means you can lose up to 10 minutes of work if running"
		ewarn "out of battery while laptop_mode is enabled."
		ewarn
		ewarn "Please see laptop-mode.txt in /usr/share/doc/${PF} for further"
		ewarn "information."
		ewarn
	fi
}
