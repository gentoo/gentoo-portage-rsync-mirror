# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/elasticsearch/elasticsearch-1.5.0.ebuild,v 1.1 2015/04/01 17:33:46 blueness Exp $

EAPI=5

inherit eutils systemd user

MY_PN="${PN%-bin}"
DESCRIPTION="Open Source, Distributed, RESTful, Search Engine"
HOMEPAGE="http://www.elasticsearch.org/"
SRC_URI="http://download.${MY_PN}.org/${MY_PN}/${MY_PN}/${MY_PN}-${PV}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip"
QA_PREBUILT="usr/share/elasticsearch/lib/sigar/libsigar-*.so"

RDEPEND="virtual/jre:1.7"

pkg_setup() {
	enewgroup ${MY_PN}
	enewuser ${MY_PN} -1 /bin/bash /var/lib/${MY_PN} ${MY_PN}
}

src_prepare() {
	rm -rf lib/sigar/*{solaris,winnt,freebsd,macosx}*
	rm -rf bin/*.{bat,exe}
	rm lib/sigar/libsigar-ia64-linux.so
	rm LICENSE.txt

	use amd64 && {
		rm lib/sigar/libsigar-x86-linux.so
	}

	use x86 && {
		rm lib/sigar/libsigar-amd64-linux.so
	}
}

src_install() {
	dodir /etc/${MY_PN}

	insinto /usr/share/doc/${P}/examples
	doins bin/${MY_PN}.in.sh
	doins config/*
	rm bin/${MY_PN}.in.sh
	rm -rf config

	insinto /usr/share/${MY_PN}
	doins -r ./*
	chmod +x "${D}"/usr/share/${MY_PN}/bin/*

	keepdir /var/{lib,log}/${MY_PN}

	local rcscript=elasticsearch.init3
	local eshome="/usr/share/${MY_PN}"
	local jarfile="${MY_PN}-${PV}.jar"
	local esclasspath="${eshome}/lib/${jarfile}:${eshome}/lib/*:${eshome}/lib/sigar/*"

	cp "${FILESDIR}/${rcscript}" "${T}" || die
	sed -i \
		-e "s|@ES_CLASS_PATH@|${esclasspath}|" \
		"${T}/${rcscript}" \
		|| die "failed to filter ${rcscript}"

	newinitd "${T}/${rcscript}" "${MY_PN}"
	newconfd "${FILESDIR}/${MY_PN}.conf" "${MY_PN}"
	systemd_newunit "${FILESDIR}"/${PN}.service2 "${PN}.service"
}

pkg_postinst() {
	elog
	elog "You may create multiple instances of ${MY_PN} by"
	elog "symlinking the init script:"
	elog "ln -sf /etc/init.d/${MY_PN} /etc/init.d/${MY_PN}.instance"
	elog
	elog "Each of the example files in /usr/share/doc/${P}/examples"
	elog "should be extracted to the proper configuration directory:"
	elog "/etc/${MY_PN} (for standard init)"
	elog "/etc/${MY_PN}/instance (for symlinked init)"
	elog
}
