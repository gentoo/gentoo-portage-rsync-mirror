# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sagan-rules/sagan-rules-20140203.ebuild,v 1.1 2014/06/26 13:24:48 maksbotan Exp $

EAPI=4

DESCRIPTION="Rules for Sagan log analyzer"
HOMEPAGE="http://sagan.softwink.com/"
#SRC_URI="http://dev.gentoo.org/~maksbotan/sagan/sagan-rules-${PV}.tar.gz"
SRC_URI="http://sagan.quadrantsec.com/rules/sagan-rules-02032014.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+lognorm"

DEPEND=""
RDEPEND="${DEPEND}"
PDEPEND="app-admin/sagan"

S=${WORKDIR}/rules

src_install() {
	insinto /etc/sagan-rules
	doins ./*.config
	doins ./*rules
	doins ./*map
	if use lognorm ; then
		doins ./*normalize.rulebase
	fi
}
