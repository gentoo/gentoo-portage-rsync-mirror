# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/webapi/webapi-0.2.ebuild,v 1.1 2013/01/13 09:27:56 radhermit Exp $

EAPI=5

inherit vim-plugin

DESCRIPTION="vim plugin: interface to Web APIs"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=4019"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-misc/curl"
