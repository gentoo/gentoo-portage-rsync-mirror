# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/hub/hub-1.11.1.ebuild,v 1.1 2014/01/15 22:18:22 ottxor Exp $

EAPI="5"

USE_RUBY="ruby18 ruby19"
RUBY_FAKEGEM_TASK_DOC=
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit readme.gentoo ruby-fakegem

ruby_add_bdepend "test? ( dev-ruby/webmock dev-util/cucumber )"

DESCRIPTION="command-line wrapper for git that makes you better at GitHub"
HOMEPAGE="https://github.com/github/hub"
SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="dev-vcs/git"

DOC_CONTENTS="You may want to add 'alias git=hub' to your .{csh,bash}rc"

src_install() {
	ruby-ng_src_install
	readme.gentoo_create_doc
}
