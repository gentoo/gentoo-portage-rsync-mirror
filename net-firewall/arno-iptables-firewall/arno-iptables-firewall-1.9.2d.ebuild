# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/arno-iptables-firewall/arno-iptables-firewall-1.9.2d.ebuild,v 1.1 2009/10/10 13:28:39 vostorga Exp $

EAPI=1

DESCRIPTION="Arno's iptables firewall script"
HOMEPAGE="http://rocky.molphys.leidenuniv.nl/"
SRC_URI="http://rocky.eld.leidenuniv.nl/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+plugins"

DEPEND=">=net-firewall/iptables-1.2.5"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}_${PV}

src_install() {
	insinto /etc/arno-iptables-firewall

	# update the default location of the environment script
	sed -e 's:/usr/local/share/:/usr/share/:' \
		etc/arno-iptables-firewall/firewall.conf > \
		"${T}"/firewall.conf || die
	doins "${T}"/firewall.conf || die
	doins etc/arno-iptables-firewall/custom-rules || die

	sed -e 's:local/::' \
		contrib/Gentoo/firewall.conf > \
		"${T}"/arno-iptables-firewall.confd || die
	newconfd "${T}"/arno-iptables-firewall.confd arno-iptables-firewall \
		|| die
	newinitd contrib/Gentoo/rc.firewall arno-iptables-firewall || die

	dobin bin/arno-fwfilter || die
	dosbin bin/arno-iptables-firewall || die

	insinto /usr/share/arno-iptables-firewall/
	doins share/arno-iptables-firewall/environment || die

	if use plugins
	then
		insinto /etc/arno-iptables-firewall/plugins
		doins etc/arno-iptables-firewall/plugins/* || die

		insinto /usr/share/arno-iptables-firewall/plugins
		doins share/arno-iptables-firewall/plugins/*.plugin || die

		exeinto /usr/share/arno-iptables-firewall/plugins
		doexe share/arno-iptables-firewall/plugins/dyndns-host-open-helper \
			|| die
		doexe share/arno-iptables-firewall/plugins/traffic-accounting-helper \
			|| die
		doexe \
			share/arno-iptables-firewall/plugins/traffic-accounting-log-rotate \
			|| die
		doexe \
			share/arno-iptables-firewall/plugins/traffic-accounting-show || die

		docinto plugins
		dodoc share/arno-iptables-firewall/plugins/*.CHANGELOG || die
	fi

	dodoc CHANGELOG README || die "dodoc failed"

	doman share/man/man1/arno-fwfilter.1 \
		share/man/man8/arno-iptables-firewall.8 || die "doman failed"
}

pkg_postinst () {
	elog "You will need to configure /etc/${PN}/firewall.conf before using this"
	elog "package.  To start the script, run:"
	elog "  /etc/init.d/${PN} start"
	echo
	elog "If you want to start this script at boot, run:"
	elog "  rc-update add ${PN} default"
	echo
	ewarn "When you start the firewall, the default is to,"
	ewarn "DROP ALL existing connections! So be carefull when installing"
	ewarn "on a remote host! There is a option to disable this behavior"
	ewarn "for testing."
	echo
	ewarn "When you stop this script, all firewall rules are flushed!"
	echo
}
