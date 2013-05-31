# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/minitest/minitest-5.0.3.ebuild,v 1.1 2013/05/31 16:05:49 flameeyes Exp $

EAPI=5
USE_RUBY="ruby18 ruby19"

# Rake is the easiest way to go through this unfortunately.
RUBY_FAKEGEM_RECIPE_TEST="rake"

RUBY_FAKEGEM_TASK_DOC="docs"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.txt Manifest.txt README.txt"

inherit ruby-fakegem

DESCRIPTION="minitest/unit is a small and fast replacement for ruby's huge and slow test/unit."
HOMEPAGE="https://github.com/seattlerb/minitest"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="doc test"

ruby_add_bdepend "
	doc? ( dev-ruby/hoe dev-ruby/rdoc )
	ruby_targets_ruby18? ( !!dev-ruby/minitest[ruby_targets_ruby18] )"

# There is a nasty bug that tests fail if minitest is loaded already
# from the system.
