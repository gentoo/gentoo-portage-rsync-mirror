# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/sabnzbd/sabnzbd-0.7.7.ebuild,v 1.2 2013/01/03 23:05:32 jsbronder Exp $

EAPI="4"

# Require python-2 with sqlite USE flag
PYTHON_DEPEND="2:2.6"
PYTHON_USE_WITH="sqlite"

inherit eutils python user

MY_P="${P/sab/SAB}"

DESCRIPTION="Binary newsgrabber with web-interface"
HOMEPAGE="http://www.sabnzbd.org/"
SRC_URI="mirror://sourceforge/sabnzbdplus/${MY_P}-src.tar.gz"

# Sabnzbd is GPL-2 but bundles software with the following licenses.
LICENSE="GPL-2 BSD LGPL-2 MIT BSD-1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+rar +ssl unzip yenc"

# We actually depend on dev-python/cherrypy as well but upstream has decided
# to bundle a custom cut of the 3.2.0 branch.  Also, sabnzbd is installed to
# /usr/share/ as upstream makes it clear they should not be in python's sitedir.
# See:  http://wiki.sabnzbd.org/unix-packaging

# TODO:  still bundled: kronos, rarfile, rsslib, ssmtplib, listquote, jso
# Probably others, see licenses/

RDEPEND="
	>=app-arch/par2cmdline-0.4
	>=dev-python/cheetah-2.0.1
	dev-python/configobj
	dev-python/feedparser
	dev-python/gntp
	dev-python/pythonutils
	net-misc/wget
	rar? ( app-arch/rar )
	ssl? ( dev-python/pyopenssl )
	unzip? ( >=app-arch/unzip-5.5.2 )
	yenc? ( dev-python/yenc )
"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	HOMEDIR="/var/lib/${PN}"
	python_set_active_version 2
	python_pkg_setup

	# Create sabnzbd group
	enewgroup ${PN}
	# Create sabnzbd user, put in sabnzbd group
	enewuser "${PN}" -1 -1 "${HOMEDIR}" "${PN}"
}

src_prepare() {
	epatch "${FILESDIR}"/use-system-configobj-and-feedparser.patch

	# remove bundled modules
	rm sabnzbd/utils/{feedparser,configobj,gntp}.py
	rm licenses/License-{feedparser,configobj,gntp}.txt
}

src_install() {
	local d

	dodir /usr/share/${PN}/sabnzbd
	insinto /usr/share/${PN}/
	doins SABnzbd.py
	fperms +x /usr/share/${PN}/SABnzbd.py
	dobin "${FILESDIR}"/sabnzbd

	for d in cherrypy email icons interfaces locale po sabnzbd tools util; do
		insinto /usr/share/${PN}/${d}
		doins -r ${d}/*
	done

	newinitd "${FILESDIR}/${PN}.initd" "${PN}"
	newconfd "${FILESDIR}/${PN}.confd" "${PN}"

	diropts -o ${PN} -g ${PN}
	dodir /etc/${PN}
	dodir /var/log/${PN}

	dodoc {ABOUT,CHANGELOG,ISSUES,README}.txt Sample-PostProc.sh licenses/*
}

pkg_postinst() {
	python_mod_optimize /usr/share/${PN}

	einfo "Default directory: ${HOMEDIR}"
	einfo ""
	einfo "Run: gpasswd -a <user> sabnzbd"
	einfo "to add an user to the sabnzbd group so it can edit sabnzbd files"
	einfo ""
	einfo "By default sabnzbd will listen on 127.0.0.1:8080"
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}
}
