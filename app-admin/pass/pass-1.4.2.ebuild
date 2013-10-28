# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/pass/pass-1.4.2.ebuild,v 1.4 2013/10/28 06:41:21 grobian Exp $

EAPI=4

inherit bash-completion-r1

DESCRIPTION="Stores, retrieves, generates, and synchronizes passwords securely using gpg, pwgen, and git"
HOMEPAGE="http://zx2c4.com/projects/password-store/"
SRC_URI="http://git.zx2c4.com/password-store/snapshot/password-store-${PV}.tar.xz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86 ~x86-macos"
IUSE="+git X zsh-completion fish-completion elibc_Darwin"

RDEPEND="
	app-crypt/gnupg
	app-admin/pwgen
	app-text/tree
	git? ( dev-vcs/git )
	X? ( x11-misc/xclip )
	elibc_Darwin? ( app-misc/getopt )
	zsh-completion? ( app-shells/zsh )
	fish-completion? ( app-shells/fish )
"

S="${WORKDIR}/password-store-${PV}"

src_prepare() {
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
	newbin src/password-store.sh pass
	doman man/pass.1
	dodoc README
	newbashcomp contrib/pass.bash-completion ${PN}
	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		newins contrib/pass.zsh-completion _pass
	fi
	if use fish-completion ; then
		insinto /usr/share/fish/completions
		newins contrib/pass.fish-completion pass.fish
	fi
	if use elibc_Darwin ; then
		insinto /usr/share/pass
		newins src/platform/darwin.sh platform.sh
	fi
}
