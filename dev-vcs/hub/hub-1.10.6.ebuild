# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/hub/hub-1.10.6.ebuild,v 1.1 2013/05/31 23:14:44 ottxor Exp $

EAPI="5"

USE_RUBY="ruby18 ruby19"
RUBY_FAKEGEM_TASK_DOC=
RUBY_FAKEGEM_EXTRADOC="HISTORY.md README.md"

inherit readme.gentoo ruby-fakegem

ruby_add_bdepend "test? ( dev-ruby/webmock dev-util/cucumber )"

DESCRIPTION="command-line wrapper for git that makes you better at GitHub"
HOMEPAGE="http://defunkt.io/hub/"
SRC_URI="https://github.com/defunkt/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND=">=dev-vcs/git-1.7.3"

DOC_CONTENTS="You may want to add 'alias git=hub' to your .{csh,bash}rc"

src_install() {
	ruby-ng_src_install
	readme.gentoo_create_doc
}
