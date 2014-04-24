# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/pass/pass-1.6.1.ebuild,v 1.1 2014/04/24 20:51:25 zx2c4 Exp $

EAPI=4

inherit bash-completion-r1

DESCRIPTION="Stores, retrieves, generates, and synchronizes passwords securely using gpg, pwgen, and git"
HOMEPAGE="http://zx2c4.com/projects/password-store/"
SRC_URI="http://git.zx2c4.com/password-store/snapshot/password-store-${PV}.tar.xz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86 ~x86-macos"
IUSE="+git X +bash-completion zsh-completion fish-completion dmenu elibc_Darwin"

RDEPEND="
	app-crypt/gnupg
	app-admin/pwgen
	>=app-text/tree-1.7.0
	git? ( dev-vcs/git )
	X? ( x11-misc/xclip )
	elibc_Darwin? ( app-misc/getopt )
	bash-completion? ( app-shells/bash-completion )
	zsh-completion? ( app-shells/zsh )
	fish-completion? ( app-shells/fish )
	dmenu? ( x11-misc/dmenu )
"

S="${WORKDIR}/password-store-${PV}"

src_prepare() {
	use elibc_Darwin || return
	# use coreutils'
	sed -i -e 's/openssl base64/base64/g' src/platform/darwin.sh || die
	# host getopt isn't cool, and we aren't brew (rip out brew reference)
	sed -i -e '/^GETOPT=/s/=.*$/=getopt-long/' src/platform/darwin.sh || die
	# make sure we can find "mount"
	sed -i -e 's:mount -t:/sbin/mount -t:' src/platform/darwin.sh || die
}

src_compile() {
	:;
}

src_install() {
	use bash-completion && export FORCE_BASHCOMP=1
	use zsh-completion && export FORCE_ZSHCOMP=1
	use fish-completion && export FORCE_FISHCOMP=1
	default
	use dmenu && dobin contrib/dmenu/passmenu
}
