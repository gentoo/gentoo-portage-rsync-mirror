# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/open4/open4-1.3.0-r2.ebuild,v 1.1 2013/12/27 02:34:18 mrueg Exp $

EAPI=5
# jruby: not compatible with its fork implementation
USE_RUBY="ruby18 ruby19 ruby20 ruby21"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="README"

inherit ruby-fakegem

DESCRIPTION="Open3::popen3 with exit status"
HOMEPAGE="http://rubyforge.org/projects/codeforpeople/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/minitest )"

all_ruby_prepare () {
	mv rakefile Rakefile || die
}

all_ruby_install() {
	all_fakegem_install

	insinto /usr/share/doc/${PF}/samples
	doins samples/*
}
