# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cloudshark/cloudshark-1.0.2.174.ebuild,v 1.1 2013/06/03 04:11:05 zerochaos Exp $

EAPI=5

inherit eutils multilib

SV="1.0.2-174"

DESCRIPTION="Instantly Upload Your WIRESHARK CAPTURES to CloudShark."
HOMEPAGE="http://appliance.cloudshark.org/plug-ins-wireshark.html"
SRC_URI="http://appliance.cloudshark.org/downloads/${PN}-plugin-${SV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

PDEPEND="net-analyzer/wireshark:=[lua]
	net-misc/curl"

S="${WORKDIR}/${PN}-${SV}"

get_PV() { local pv=$(best_version $1); pv=${pv#$1-}; pv=${pv%-r*}; pv=${pv//_}; echo ${pv}; }

src_prepare() {
	#cloudshark isn't meant to be installed systemwide, most of this is caused by that fact
	epatch "${FILESDIR}"/cs_log_dir.patch

	sed -i "s#%s/cloudshark_init.lua#/usr/$(get_libdir)/wireshark/plugins/$(get_PV net-analyzer/wireshark)/cloudshark_init.lua#" cloudshark.lua
	#the echo line seemed a cleaner solution but it causes errors, looks like it expects windows paths only
	#echo "CLOUDSHARK_CABUNDLE = /usr/$(get_libdir)/wireshark/plugins/$(get_PV net-analyzer/wireshark)/curl-ca-bundle.crt" >> cloudshark_init.default
	sed -i "s#%s/curl-ca-bundle.crt#/usr/$(get_libdir)/wireshark/plugins/$(get_PV net-analyzer/wireshark)/curl-ca-bundle.crt#" cloudshark.lua

	#stuff to fix cloudshark_init.default to be more sane
	#sed -i 's#CLOUDSHARK_TSHARK = "n"#CLOUDSHARK_TSHARK = "y"#' cloudshark_init.default (tshark support doesn't seem to work)
}

src_test() {
	[ "md5sum install-unix" -ne "405cb4dd526bf5261bbb56714baa67f0  install-unix" ] && die "install instructions have changed"
}

src_install() {
	insinto /usr/$(get_libdir)/wireshark/plugins/$(get_PV net-analyzer/wireshark)
	doins cloudshark.lua json.lua version.lua curl-ca-bundle.crt
	newins cloudshark_init.default cloudshark_init.lua
	dodoc CLOUDSHARK_README.txt
}
