# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ipset/ipset-6.8.ebuild,v 1.3 2011/09/16 13:26:44 chainsaw Exp $

EAPI="4"
inherit autotools linux-info linux-mod

DESCRIPTION="IPset tool for iptables, successor to ippool."
HOMEPAGE="http://ipset.netfilter.org/"
SRC_URI="http://ipset.netfilter.org/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="modules"

RDEPEND=">=net-firewall/iptables-1.4.4
	net-libs/libmnl"
DEPEND="${RDEPEND}"

# configurable from outside, e.g. /etc/make.conf
IP_NF_SET_MAX=${IP_NF_SET_MAX:-256}

BUILD_TARGETS="modules"
MODULE_NAMES_ARG="kernel/net/netfilter/ipset/:${S}/kernel/net/netfilter/ipset"
MODULE_NAMES="xt_set(kernel/net/netfilter/ipset/:${S}/kernel/net/netfilter/)"
for i in ip_set{,_bitmap_{ip{,mac},port},_hash_{ip{,port{,ip,net}},net,net{port,iface}},_list_set}; do
	MODULE_NAMES+=" ${i}(${MODULE_NAMES_ARG})"
done
CONFIG_CHECK="NETFILTER IP6_NF_IPTABLES !IP_SET"
ERROR_NETFILTER="ipset requires NETFILTER support in your kernel."
ERROR_IP6_NF_IPTABLES="ipset requires IP6_NF_IPTABLES support in your kernel."
ERROR_IP_SET="There is IP_SET support in your kernel. Please build ipset with modules USE flag disabled or you may have troubles loading correct modules."

check_header_patch() {
	if ! $(grep -q NFNL_SUBSYS_IPSET "${KV_DIR}/include/linux/netfilter/nfnetlink.h"); then
		eerror "Sorry, but you have to patch kernel sources with the following patch:"
		eerror " # cd ${KV_DIR}"
		eerror " # patch -i ${S}/netlink.patch -p1"
		eerror "You do not need to recompile your kernel."
		die "Unpatched kernel"
	fi
}

pkg_setup() {
	get_version

	build_modules=0
	if use modules; then
		kernel_is -lt 2 6 35 && die "${PN} requires kernel greater then 2.6.35."
		if linux_config_src_exists && linux_chkconfig_builtin "MODULES" ; then
			if linux_chkconfig_builtin "IP_NF_SET"; then #274577
				einfo "Modular kernel detected but IP_NF_SET=y, will not build kernel modules"
			else
				if kernel_is -gt 2 6 39; then
					einfo "This kernel has modules inside, will not build kernel modules"
				else
					einfo "Modular kernel detected, will build kernel modules"
					build_modules=1
				fi
			fi
		else
			einfo "Nonmodular kernel detected, will not build kernel modules"
		fi
	fi

	[[ ${build_modules} -eq 1 ]] && linux-mod_pkg_setup
}

src_prepare() {
	[[ ${build_modules} -eq 1 ]] && check_header_patch
	eautoreconf
}

src_configure() {
	econf \
		--with-maxsets=${IP_NF_SET_MAX} \
		--libdir="${EPREFIX}"/$(get_libdir) \
		--with-ksource="${KV_DIR}" \
		--with-kbuild="${KV_OUT_DIR}"
}

src_compile() {
	einfo "Building userspace"
	emake

	if [[ ${build_modules} -eq 1 ]]; then
		einfo "Building kernel modules"
		set_arch_to_kernel
		emake modules
	fi
}

src_install() {
	einfo "Installing userspace"
	emake DESTDIR="${D}" install

	if [[ ${build_modules} -eq 1 ]]; then
		einfo "Installing kernel modules"
		linux-mod_src_install
	fi
	find "${ED}" \( -name '*.la' -o -name '*.a' \) -exec rm -f '{}' +
}

pkg_postinst() {
	linux-mod_pkg_postinst
	elog "Note you need to rebuid and run kernel with netlink.patch or you'll get error:"
	elog "Kernel error received: Invalid argument"
}
