# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ipset/ipset-4.5.ebuild,v 1.4 2011/09/16 13:26:44 chainsaw Exp $

EAPI="2"

inherit eutils versionator toolchain-funcs linux-mod

DESCRIPTION="IPset tool for iptables, successor to ippool."
HOMEPAGE="http://ipset.netfilter.org/"
SRC_URI="http://ipset.netfilter.org/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="modules"

RDEPEND=">=net-firewall/iptables-1.4.4"
DEPEND="${RDEPEND}"

# configurable from outside
[ -z "${IP_NF_SET_MAX}" ] && IP_NF_SET_MAX=256
[ -z "${IP_NF_SET_HASHSIZE}" ] && IP_NF_SET_HASHSIZE=1024
BUILD_PARAMS="IP_NF_SET_MAX=$IP_NF_SET_MAX IP_NF_SET_HASHSIZE=${IP_NF_SET_HASHSIZE}"
# module fun
BUILD_TARGETS="all"
MODULE_NAMES_ARG="kernel/net/ipv4/netfilter:${S}/kernel"
MODULE_NAMES=""
for i in ip_set{,_{setlist,{ip,port,macip}map,{ip,net,ipport,ipportip,ipportnet}hash,iptree{,map}}} \
	ipt_{SET,set}; do
	MODULE_NAMES="${MODULE_NAMES} ${i}(${MODULE_NAMES_ARG})"
done
# sanity
CONFIG_CHECK="NETFILTER"
ERROR_CFG="ipset requires netfilter support in your kernel."

pkg_setup() {
	get_version

	build_modules=0
	if use modules; then
		if linux_config_src_exists && linux_chkconfig_builtin "MODULES" ; then
			if linux_chkconfig_builtin "IP_NF_SET"; then #274577
				einfo "Modular kernel detected but IP_NF_SET=y, will not build kernel modules"
			else
				build_modules=1
				einfo "Modular kernel detected, will build kernel modules"
			fi
		else
			einfo "Nonmodular kernel detected, will not build kernel modules"
		fi
	fi

	[[ ${build_modules} -eq 1 ]] && linux-mod_pkg_setup
	myconf="${myconf} PREFIX="
	myconf="${myconf} LIBDIR=/$(get_libdir)"
	myconf="${myconf} BINDIR=/sbin"
	myconf="${myconf} MANDIR=/usr/share/man"
	myconf="${myconf} INCDIR=/usr/include"
	myconf="${myconf} NO_EXTRA_WARN_FLAGS=yes"
	export myconf
}

src_prepare() {
	sed -i \
		-e 's/KERNELDIR/(KERNELDIR)/g' \
		-e 's/^(\?KERNEL_\?DIR.*/KERNELDIR ?= /' \
		-e '/^all::/iV ?= 0' \
		-e '/^all::/iKBUILD_OUTPUT ?=' \
		-e '/$(MAKE)/{s/$@/ V=$(V) KBUILD_OUTPUT=$(KBUILD_OUTPUT) modules/}' \
		"${S}"/kernel/Makefile
}

src_compile() {
	einfo "Building userspace"
	emake \
		CC="$(tc-getCC)" \
		COPT_FLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		${myconf} \
		binaries || die "failed to build"

	if [[ ${build_modules} -eq 1 ]]; then
		einfo "Building kernel modules"
		cd "${S}/kernel"
		export KERNELDIR="${KERNEL_DIR}"
		linux-mod_src_compile || die "failed to build modules"
	fi
}

src_install() {
	einfo "Installing userspace"
	emake DESTDIR="${D}" ${myconf} binaries_install || die "failed to package"

	if [[ ${build_modules} -eq 1 ]]; then
		einfo "Installing kernel modules"
		cd "${S}/kernel"
		export KERNELDIR="${KERNEL_DIR}"
		linux-mod_src_install
	fi
}
