# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/porticron/porticron-0.5.3.ebuild,v 1.1 2010/11/12 07:49:07 hollow Exp $

EAPI="3"

GITHUB_AUTHOR="hollow"
GITHUB_PROJECT="porticron"
GITHUB_COMMIT="748c650"

DESCRIPTION="porticron is a cron script to sync portage and send update mails to root"
HOMEPAGE="http://github.com/hollow/porticron"
SRC_URI="http://nodeload.github.com/${GITHUB_AUTHOR}/${GITHUB_PROJECT}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND="net-dns/bind-tools"

S="${WORKDIR}"/${GITHUB_AUTHOR}-${GITHUB_PROJECT}-${GITHUB_COMMIT}

src_install() {
	dosbin bin/porticron
	insinto /etc
	doins etc/porticron.conf
}
