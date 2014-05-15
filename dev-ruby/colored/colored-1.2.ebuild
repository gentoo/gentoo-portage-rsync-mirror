# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/colored/colored-1.2.ebuild,v 1.4 2014/05/15 01:21:44 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21 jruby"

RUBY_FAKEGEM_TASK_DOC=""

inherit ruby-fakegem

DESCRIPTION="Console coloring"
HOMEPAGE="http://github.com/defunkt"
LICENSE="MIT"

KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

each_ruby_prepare() {
	sed -i -e '/[Mm][Gg]/d' Rakefile || die
}
