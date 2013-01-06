# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/fromcvs/fromcvs-0_pre20120214.ebuild,v 1.2 2012/08/16 03:57:44 flameeyes Exp $

EAPI=4

USE_RUBY="ruby18 ree18"

inherit ruby-ng

MY_PV="${PV#0_pre}"

DESCRIPTION="fromcvs converts cvs to git, hg or sqlite database"
HOMEPAGE="http://gitorious.org/fromcvs"
# downloaded from gitorious hash, no proper tarballs available
SRC_URI="http://dev.gentoo.org/fromcvs-${MY_PV}.tar.gz"

RUBY_PATCHES="0001-Fix-379271-require-rubygems-before-other-deps.patch"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+git mercurial sqlite"

RUBY_S="${PN}-${PN}"

RDEPEND="${RDEPEND}
	git? ( dev-vcs/git )
	mercurial? ( dev-vcs/mercurial )"

ruby_add_rdepend "dev-ruby/rcsparse
	>=dev-ruby/rbtree-0.3.0-r2
	sqlite? ( dev-ruby/sqlite3 )"

all_ruby_prepare() {
	# prepare scripts that will go into bin
	for script in togit.rb tohg.rb todb.rb;do
		sed -i '1 i #!/usr/bin/ruby' ${script} || die
		mv ${script} ${script%.rb} || die
	done
}

each_ruby_install() {
	insinto $(ruby_rbconfig_value 'sitedir')
	doins *.rb || die "Installation of rb files failed"

	use git && dobin togit
	use mercurial && dobin tohg
	use sqlite && dobin todb
}
