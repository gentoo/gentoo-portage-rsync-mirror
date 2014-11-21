# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/zsh-completion/zsh-completion-99999999.ebuild,v 1.2 2014/11/21 08:28:32 pinkbyte Exp $

EAPI=5

inherit eutils git-2

EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/zsh-completion.git"

DESCRIPTION="Programmable Completion for zsh (includes emerge and ebuild commands)"
HOMEPAGE="http://git.overlays.gentoo.org/gitweb/?p=proj/zsh-completion.git"

LICENSE="ZSH"
SLOT="0"

RDEPEND=">=app-shells/zsh-4.3.5"

src_prepare() {
	epatch_user
}

src_install() {
	insinto /usr/share/zsh/site-functions
	doins _*

	dodoc AUTHORS
}
