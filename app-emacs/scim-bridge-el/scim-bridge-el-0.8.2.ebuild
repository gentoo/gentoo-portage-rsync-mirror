# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/scim-bridge-el/scim-bridge-el-0.8.2.ebuild,v 1.2 2013/09/16 11:57:20 heroxbd Exp $

EAPI=5
inherit elisp versionator

MY_PN=${PN/-el/.el}
MY_BR=$(get_version_component_range 1-2)
DESCRIPTION="a SCIM-Bridge client for Emacs"
HOMEPAGE="https://launchpad.net/scim-bridge.el"
SRC_URI="https://launchpad.net/${MY_PN}/${MY_BR}/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=""
RDEPEND="app-i18n/scim
	app-editors/emacs"

src_prepare () {
	epatch "${FILESDIR}"/${PN}-0.8.2-im-agent.patch
}
