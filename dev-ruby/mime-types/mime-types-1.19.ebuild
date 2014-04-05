# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mime-types/mime-types-1.19.ebuild,v 1.8 2014/04/05 14:20:32 mrueg Exp $

EAPI=4

USE_RUBY="ruby19 jruby"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.rdoc README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Provides a mailcap-like MIME Content-Type lookup for Ruby."
HOMEPAGE="http://rubyforge.org/projects/mime-types"

LICENSE="Ruby Artistic GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_bdepend "doc? ( dev-ruby/hoe dev-ruby/rubyforge )
	test? ( dev-ruby/hoe dev-ruby/rubyforge )"

all_ruby_prepare() {
	# when rcov is installed, and a new enough Hoe is installed as
	# well, the Rakefile will fail because Hoe::test_files is no
	# longer defined. Since we don't use rcov for testing, we just
	# disable the whole section unconditionally.
	sed -i -e '/rcovtask/,/end/ s:^:#:' Rakefile || die "Rakefile fix failed"
}
