# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/gentoo-zsh-completions/gentoo-zsh-completions-99999999.ebuild,v 1.4 2014/11/21 14:08:11 radhermit Exp $

EAPI=5

inherit git-r3

EGIT_REPO_URI="https://github.com/radhermit/gentoo-zsh-completions.git"

DESCRIPTION="Gentoo specific zsh completion support (includes emerge and ebuild commands)"
HOMEPAGE="https://github.com/radhermit/gentoo-zsh-completions"

LICENSE="ZSH"
SLOT="0"

RDEPEND=">=app-shells/zsh-4.3.5"

src_install() {
	insinto /usr/share/zsh/site-functions
	doins src/_*

	dodoc AUTHORS
}
