# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/rss2email/rss2email-2.69.ebuild,v 1.3 2010/12/18 03:25:14 sping Exp $

EAPI="2"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit eutils python

DEBIAN_PV="2.65"

DESCRIPTION="A python script that converts RSS/Atom newsfeeds to email"
HOMEPAGE="http://www.allthingsrss.com/rss2email"
SRC_URI="http://www.allthingsrss.com/${PN}/${P}.tar.gz
	mirror://debian/pool/main/r/${PN}/${PN}_${DEBIAN_PV}-1.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-util/patchutils"
RDEPEND="dev-python/feedparser
	dev-python/html2text"

src_prepare() {
	epatch "${FILESDIR}"/${P}-config-location.patch

	# Extract man page from Debian patch
	zcat "${DISTDIR}"/${PN}_${DEBIAN_PV}-1.diff.gz \
		| filterdiff -i '*/r2e.1' \
		> "${S}"/r2e.1.patch || die
	EPATCH_OPTS="-p1" epatch r2e.1.patch
}

src_install() {
	my_install() {
		insinto "$(python_get_sitedir)"/${PN}
		newins rss2email.py main.py || die

		insinto /etc/${PN}
		doins config.py || die
	}
	python_execute_function my_install

	dodoc CHANGELOG readme.html || die
	doman r2e.1 || die

	# Replace r2e wrapper
	cat <<-"EOF" >r2e
		#! /bin/sh
		SITE_PACKAGES=`python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()"`
		CONF_DIR=${HOME}/.rss2email
		mkdir -p "${CONF_DIR}"
		exec python "${SITE_PACKAGES}"/rss2email/main.py "${CONF_DIR}"/feeds.dat $*
	EOF

	dobin r2e || die
}
