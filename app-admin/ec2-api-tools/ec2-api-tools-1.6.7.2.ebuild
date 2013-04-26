# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/ec2-api-tools/ec2-api-tools-1.6.7.2.ebuild,v 1.1 2013/04/26 21:06:55 tomwij Exp $

EAPI="5"

inherit versionator

DESCRIPTION="These command-line tools serve as the client interface to the Amazon EC2 web service"
HOMEPAGE="http://developer.amazonwebservices.com/connect/entry.jspa?externalID=351&categoryID=88"
SRC_URI="http://s3.amazonaws.com/ec2-downloads/${PN}-${PV}.zip"

S=${WORKDIR}/${PN}-${PV}

LICENSE="Amazon"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

DEPEND="app-arch/unzip"
RDEPEND="virtual/jre"

src_prepare() {
	find . -name '*.cmd' -delete || die "Failed to remove redundant cmd files."
}

src_install() {
	exeinto /usr/bin
	doexe bin/*

	insinto /usr/lib
	doins lib/*.jar

	dodir /etc/env.d
	echo "EC2_HOME=/usr" > "${T}"/99${PN} || die "Failed to write configuration variable."
	doenvd "${T}"/99${PN}

	dodoc THIRDPARTYLICENSE.TXT
}

pkg_postinst() {
	ewarn "Remember to run: env-update && source /etc/profile if you plan"
	ewarn "to use these tools in a shell before logging out (or restarting"
	ewarn "your login manager)"
	elog ""
	elog "You need to put the following in your ~/.bashrc replacing the"
	elog "values with the full paths to your key and certificate."
	elog ""
	elog "  export EC2_PRIVATE_KEY=/path/to/pk-HKZYKTAIG2ECMXYIBH3HXV4ZBZQ55CLO.pem"
	elog "  export EC2_CERT=/path/to/cert-HKZYKTAIG2ECMXYIBH3HXV4ZBZQ55CLO.pem"
}
