# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/hoe/hoe-2.13.0-r1.ebuild,v 1.13 2014/10/29 18:48:28 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_TASK_DOC="docs"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.txt Manifest.txt README.txt"

RUBY_FAKEGEM_EXTRAINSTALL="template"

inherit ruby-fakegem

DESCRIPTION="Hoe extends rake to provide full project automation"
HOMEPAGE="http://seattlerb.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

# - also requires dev-ruby/hoe-seattlerb for 1.9;
# - dev-ruby/gemcutter is an optional dependency at both runtime and
#   test-time, at least for us;
# - rubyforge is loaded at runtime when needed, so we don't strictly
#   depend on it at runtime, but we need it for tests (for now);
ruby_add_bdepend "test? ( virtual/ruby-minitest >=dev-ruby/rubyforge-2.0.4 )"

ruby_add_rdepend ">=dev-ruby/rake-0.8.7 >=dev-ruby/rdoc-3.10"

all_ruby_prepare() {
	# Make test regexp more lenient to cover the way we name the binaries.
	sed -i -e 's/sudo gem/sudo .?gem/' -e 's/\^gem/^.?gem/' test/test_hoe.rb || die
}
