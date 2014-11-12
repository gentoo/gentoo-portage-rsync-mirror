# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/porticron/porticron-0.6.ebuild,v 1.7 2014/11/12 20:31:56 sping Exp $

EAPI="3"

GITHUB_AUTHOR="hollow"
GITHUB_PROJECT="porticron"
GITHUB_COMMIT="eaf2457"

DESCRIPTION="porticron is a cron script to sync portage and send update mails to root"
HOMEPAGE="https://github.com/gentoo/porticron"
SRC_URI="http://nodeload.github.com/${GITHUB_AUTHOR}/${GITHUB_PROJECT}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm hppa ppc x86"
IUSE=""

DEPEND=""
RDEPEND="net-dns/bind-tools"

S="${WORKDIR}"/${GITHUB_AUTHOR}-${GITHUB_PROJECT}-${GITHUB_COMMIT}

src_install() {
	dosbin bin/porticron
	insinto /etc
	doins etc/porticron.conf
}
