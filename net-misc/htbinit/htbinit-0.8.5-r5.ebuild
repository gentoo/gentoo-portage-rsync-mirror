# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/htbinit/htbinit-0.8.5-r5.ebuild,v 1.4 2012/09/30 18:11:19 armin76 Exp $

EAPI=2
inherit eutils linux-info

DESCRIPTION="Sets up Hierachical Token Bucket based traffic control (QoS) with iproute2"
HOMEPAGE="http://www.sourceforge.net/projects/htbinit"
SRC_URI="mirror://sourceforge/htbinit/htb.init-v${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="ipv6 esfq"

DEPEND="sys-apps/iproute2"

S=${WORKDIR}

pkg_setup() {
	for i in NET_SCH_HTB NET_SCH_SFQ NET_CLS_FW NET_CLS_U32 NET_CLS_ROUTE ; do
		CONFIG_CHECK="${CONFIG_CHECK} ~${i}"
		eval "export WARNING_${i}='module needed at runtime!'"
	done
	use esfq && CONFIG_CHECK="${CONFIG_CHECK} ~NET_SCH_ESFQ"
	WARNING_NET_SCH_ESFQ='module needed at runtime! Available at http://fatooh.org/esfq-2.6/'
	export CONFIG_CHECK
	linux-info_pkg_setup
}

src_unpack() {
	cp "${DISTDIR}"/htb.init-v${PV} "${S}"/htb.init
}

src_prepare() {
	sed -i 's|/etc/sysconfig/htb|/etc/htb|g' "${S}"/htb.init
	epatch "${FILESDIR}"/htb.init-v0.8.5_tos.patch
	use ipv6 && epatch "${FILESDIR}"/htb_0.8.5_ipv6.diff
	use esfq && epatch "${FILESDIR}"/htb_0.8.5_esfq.diff
	epatch "${FILESDIR}"/prio_rule.patch
	epatch "${FILESDIR}"/timecheck_fix.patch
	epatch "${FILESDIR}"/htb.init_find_fix.patch
}

src_compile() {
	:
}

src_install() {
	dosbin htb.init

	newinitd "${FILESDIR}"/htbinit.rc htbinit

	keepdir /etc/htb
}

pkg_postinst() {
	einfo 'Run "rc-update add htbinit default" to run htb.init at startup.'
	einfo 'Please, read carefully the htb.init documentation.'
	einfo 'new directory to store configuration /etc/htb'
}
