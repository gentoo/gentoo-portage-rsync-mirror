# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-pf/freebsd-pf-9.2_rc2.ebuild,v 1.1 2013/08/22 15:45:48 aballier Exp $

inherit bsdmk freebsd user

DESCRIPTION="FreeBSD's base system libraries"
SLOT="0"

IUSE=""

# Crypto is needed to have an internal OpenSSL header
if [[ ${PV} != *9999* ]]; then
	KEYWORDS="~amd64-fbsd ~x86-fbsd"
	SRC_URI="mirror://gentoo/${USBIN}.tar.bz2
			mirror://gentoo/${SBIN}.tar.bz2
			mirror://gentoo/${CONTRIB}.tar.bz2
			mirror://gentoo/${ETC}.tar.bz2"
fi

RDEPEND="net-libs/libpcap"
DEPEND="${RDEPEND}
	dev-libs/libevent
	=sys-freebsd/freebsd-mk-defs-${RV}*
	=sys-freebsd/freebsd-sources-${RV}*"

S="${WORKDIR}"

SUBDIRS="usr.sbin/authpf sbin/pfctl sbin/pflogd usr.sbin/ftp-proxy/ftp-proxy"

pkg_setup() {
	enewgroup authpf 63
	mymakeopts="${mymakeopts} NO_MANCOMPRESS= NO_INFOCOMPRESS= "
}

src_unpack() {
	freebsd_src_unpack
	# pcap-int.h redefines snprintf as pcap_snprintf
	epatch "${FILESDIR}/${PN}-9.0-pcap_pollution.patch"
	# Use system's libevent
	epatch "${FILESDIR}/${PN}-9.0-libevent.patch"
	epatch "${FILESDIR}/${PN}-9.0-pflogd.patch"
	epatch "${FILESDIR}/${PN}-9.0-bpf.patch"
	epatch "${FILESDIR}/${PN}-9.0-getline.patch"
	# Link in kernel sources
	ln -s "/usr/src/sys" "${WORKDIR}/sys"
}

src_compile() {
	for dir in ${SUBDIRS}; do
		einfo "Starting make in ${dir}"
		cd "${S}/${dir}"
		mkmake || die "Make ${dir} failed"
	done
}

src_install() {
	for dir in ${SUBDIRS}; do
		einfo "Starting install in ${dir}"
		cd "${S}/${dir}"
		mkinstall || die "Install ${dir} failed"
	done

	cd "${WORKDIR}"/etc
	insinto /etc
	doins pf.os
	# pf.initd provided by openrc, but no pf.confd
	newconfd "${FILESDIR}/pf.confd" pf
}
